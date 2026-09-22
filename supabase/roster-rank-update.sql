-- 기존 등급 데이터를 새 등급 체계로 변경합니다.
alter table public.roster_members
  alter column rank set default '엔지니어';
update public.roster_members set rank = '전쟁리더' where rank in ('연맹장', '부연맹장');
update public.roster_members set rank = '엔지니어' where rank = '일반';
