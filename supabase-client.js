// oMy Supabase client configuration
// publishable/anon keys are safe to use in browser code when RLS is enabled.
const OMY_SUPABASE_URL = 'https://dovgqdmxboyyintcrusd.supabase.co';
const OMY_SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_eZ9SCZexkN7TrkJQsM7UeQ_0hrQQyo9';

let omySupabase = null;

async function initOmySupabase() {
  if (omySupabase) return omySupabase;
  if (!window.supabase) throw new Error('Supabase client library is not loaded.');
  omySupabase = window.supabase.createClient(
    OMY_SUPABASE_URL,
    OMY_SUPABASE_PUBLISHABLE_KEY
  );
  return omySupabase;
}

async function getOmySession() {
  const client = await initOmySupabase();
  const { data, error } = await client.auth.getSession();
  if (error) throw error;
  return data.session;
}

async function signUpOmy(email, password, nickname) {
  const client = await initOmySupabase();
  return client.auth.signUp({
    email,
    password,
    options: { data: { nickname } }
  });
}

async function signInOmy(email, password) {
  const client = await initOmySupabase();
  return client.auth.signInWithPassword({ email, password });
}

async function signOutOmy() {
  const client = await initOmySupabase();
  return client.auth.signOut();
}
