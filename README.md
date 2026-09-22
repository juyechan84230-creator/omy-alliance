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
