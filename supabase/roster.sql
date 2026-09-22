create table if not exists public.roster_members (
  id uuid primary key default gen_random_uuid(),
  alliance_id uuid not null references public.alliances(id) on delete cascade,
  name text not null,
  rank text not null default '일반',
  note text,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  unique(alliance_id, name)
);
alter table public.roster_members enable row level security;
create policy roster_members_read on public.roster_members for select to authenticated using (true);
create or replace function public.admin_add_roster_member(admin_code text, target_alliance_id uuid, member_name text, member_rank text, member_note text)
returns uuid language plpgsql security definer set search_path=public as $$
declare new_id uuid;
begin
 if admin_code <> '6794' then raise exception 'invalid admin code'; end if;
 insert into public.roster_members(alliance_id,name,rank,note) values(target_alliance_id,member_name,member_rank,member_note)
 on conflict(alliance_id,name) do update set rank=excluded.rank,note=excluded.note,active=true
 returning id into new_id;
 return new_id;
end;$$;
grant execute on function public.admin_add_roster_member(text,uuid,text,text,text) to authenticated;
notify pgrst,'reload schema';
