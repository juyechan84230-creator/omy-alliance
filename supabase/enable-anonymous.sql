-- 간편 입장 MVP용 추가 정책
create policy "alliances_public_read" on public.alliances for select to anon, authenticated using (true);
create policy "alliances_authenticated_insert" on public.alliances for insert to authenticated with check (created_by = auth.uid());

-- Storage: battle-files 버킷에서 로그인 세션 사용자의 파일 업로드/조회 허용
create policy "battle_files_authenticated_insert" on storage.objects for insert to authenticated with check (bucket_id = 'battle-files');
create policy "battle_files_authenticated_read" on storage.objects for select to authenticated using (bucket_id = 'battle-files');
