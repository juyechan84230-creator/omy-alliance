-- oMy 기본 데이터 구조 (Supabase PostgreSQL)
create extension if not exists "uuid-ossp";

create table if not exists public.alliances (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  invite_code text unique not null,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nickname text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.alliance_members (
  id uuid primary key default uuid_generate_v4(),
  alliance_id uuid not null references public.alliances(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  role text not null default 'member' check (role in ('leader','officer','member')),
  note text,
  joined_at timestamptz not null default now(),
  unique (alliance_id, user_id)
);

create table if not exists public.battle_records (
  id uuid primary key default uuid_generate_v4(),
  alliance_id uuid not null references public.alliances(id) on delete cascade,
  battle_date date not null,
  battle_type text not null check (battle_type in ('연맹 대결','사막 전투','협곡 전투')),
  member_name text not null,
  attended boolean not null default false,
  score integer not null default 0,
  note text,
  uploaded_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  unique (alliance_id, battle_date, battle_type, member_name)
);

create table if not exists public.uploaded_files (
  id uuid primary key default uuid_generate_v4(),
  alliance_id uuid not null references public.alliances(id) on delete cascade,
  file_name text not null,
  storage_path text,
  row_count integer not null default 0,
  uploaded_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.alliances enable row level security;
alter table public.alliance_members enable row level security;
alter table public.battle_records enable row level security;
alter table public.uploaded_files enable row level security;

-- MVP 단계의 기본 정책: 로그인 사용자만 읽고 쓸 수 있도록 시작
create policy "profiles_self_read" on public.profiles for select using (id = auth.uid());
create policy "profiles_self_update" on public.profiles for update using (id = auth.uid());
create policy "profiles_self_insert" on public.profiles for insert with check (id = auth.uid());
create policy "alliance_members_read" on public.alliance_members for select using (user_id = auth.uid());
create policy "battle_records_authenticated_read" on public.battle_records for select to authenticated using (true);
create policy "battle_records_authenticated_insert" on public.battle_records for insert to authenticated with check (uploaded_by = auth.uid());
create policy "uploaded_files_authenticated_read" on public.uploaded_files for select to authenticated using (uploaded_by = auth.uid());
create policy "uploaded_files_authenticated_insert" on public.uploaded_files for insert to authenticated with check (uploaded_by = auth.uid());
