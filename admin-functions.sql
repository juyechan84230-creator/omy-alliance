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
