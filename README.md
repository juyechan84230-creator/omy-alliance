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

## 간편 입장
현재 초기 버전은 이메일 로그인 대신 닉네임과 연맹 코드(`OMY2026`)로 입장합니다. 이 방식은 프로토타입용이며, 실제 운영 시 연맹 코드 검증은 서버 측에서 처리해야 합니다.
