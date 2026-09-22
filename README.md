# oMy 연맹 운영센터

실제 서비스로 확장하기 위한 초기 파일입니다.

## 현재 포함
- `index.html`: 대시보드 프로토타입
- `supabase/schema.sql`: 로그인·연맹원·전투 기록·업로드 파일용 DB 스키마
- `supabase-client.js`: 제공한 Supabase 프로젝트 연결 설정
- `.env.example`: Supabase 연결 환경변수 예시

## 시작 순서
1. Supabase에서 새 프로젝트를 생성합니다.
2. SQL Editor에 `supabase/schema.sql` 내용을 붙여넣고 실행합니다.
3. `supabase-client.js`의 연결 정보가 현재 프로젝트에 맞는지 확인합니다.
4. Supabase Authentication에서 Email provider를 활성화합니다.
5. Vercel에 배포합니다.

현재 `index.html`은 브라우저 저장 기반 프로토타입이며, 다음 단계에서 Supabase 인증과 실제 DB 저장을 연결합니다.

## v0.5 공유 동기화
입장 시 Supabase battle_records를 읽어 대시보드와 전투 기록 화면을 갱신합니다. `supabase/enable-anonymous.sql`을 한 번 실행한 뒤 배포하세요.

## v0.7 관리자 기록 삭제
`supabase/admin-functions.sql`을 SQL Editor에서 한 번 실행하면 관리자 모드에서 전투 기록 삭제가 가능합니다. 관리자 코드는 DB 함수에서 검증됩니다.

## v0.8 관리자 기록 수정
`supabase/admin-functions.sql`을 다시 전체 실행하면 수정용 RPC가 추가됩니다. 관리자 모드에서 수정 버튼을 누르고 항목별로 값을 변경할 수 있습니다.

## v0.9 연맹원 공유 관리
`supabase/roster.sql`을 SQL Editor에서 실행하세요. 관리자 모드에서 추가한 연맹원이 Supabase에 저장되고 다른 사용자에게도 공유됩니다.

## v1.0 왼쪽 탭 연결
왼쪽 메뉴가 대시보드·연맹원 관리·연맹 대결·사막 전투·협곡 전투·자료 업로드 화면으로 이동합니다.

## v1.1 실시간 반영
Supabase에서 `Database → Replication`으로 이동해 `battle_records` 테이블의 Realtime을 활성화하면, 다른 사용자의 업로드·수정·삭제가 화면 새로고침 없이 반영됩니다.

## v1.2 분석 기간 필터
전투 기록 분석 영역에 전체 기간·최근 7일·최근 30일 필터를 추가했습니다.

## v2.0 종합 분석
개인 점수 TOP 5와 전투 유형별 참여율 요약을 추가했습니다. 기존 Supabase 기록을 기준으로 자동 계산됩니다.

## v2.1 관리자 간 연맹원 동기화
관리자가 연맹원을 추가·수정하면 같은 연맹에 접속한 다른 관리자 화면도 자동으로 갱신됩니다. `roster_members`가 `supabase_realtime` publication에 등록되어 있어야 합니다.

## v2.2 모바일 최적화
모바일 하단 메뉴, 터치 영역, 카드·표 레이아웃, 필터 배치를 최적화했습니다.

## v2.3 사용자 이름 표시
입장 화면에서 입력한 닉네임을 대시보드 인사말과 왼쪽 사용자 영역에 자동 표시합니다.

## v2.4 연맹원 등급
연맹원 등급을 `엔지니어`와 `전쟁리더`로 구분했습니다. 기존 데이터가 있으면 `supabase/roster-rank-update.sql`을 한 번 실행하세요.
