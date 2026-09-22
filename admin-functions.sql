-- 관리자 코드 검증은 브라우저가 아닌 Supabase 함수에서 처리합니다.
create or replace function public.admin_delete_battle_record(record_id uuid, admin_code text)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if admin_code <> '6794' then
    raise exception 'invalid admin code';
  end if;
  delete from public.battle_records where id = record_id;
end;
$$;
grant execute on function public.admin_delete_battle_record(uuid, text) to authenticated;

create or replace function public.admin_update_battle_record(
  admin_code text,
  record_id uuid,
  new_battle_date date,
  new_battle_type text,
  new_member_name text,
  new_attended boolean,
  new_score integer,
  new_note text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if admin_code <> '6794' then
    raise exception 'invalid admin code';
  end if;
  update public.battle_records
  set battle_date = new_battle_date,
      battle_type = new_battle_type,
      member_name = new_member_name,
      attended = new_attended,
      score = new_score,
      note = new_note
  where id = record_id;
end;
$$;
grant execute on function public.admin_update_battle_record(text, uuid, date, text, text, boolean, integer, text) to authenticated;
notify pgrst, 'reload schema';
