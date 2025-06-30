# sistema-login-cadastro


### 🔙 Backend
- Node.js + Express
- Prisma ORM (SQLite)
- Firebase Realtime Database
- JWT para autenticação
- Bcrypt para segurança de senhas


---

## ⚙️ Como rodar o projeto

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo
2. Instale as dependências
npm install
3. Configure o banco de dados Prisma (SQLite)
npx prisma migrate dev --name init
npx prisma generate
npx prisma studio

4. Configure o Firebase
Crie um arquivo firebase.js com sua configuração do Firebase:

import { initializeApp } from "firebase/app";
import { getDatabase } from "firebase/database";

const firebaseConfig = {
  apiKey: "...",
  authDomain: "...",
  databaseURL: "...",
  projectId: "...",
  storageBucket: "...",
  messagingSenderId: "...",
  appId: "..."
};

const app = initializeApp(firebaseConfig);
const database = getDatabase(app);

5. Inicie o servidor

npx  index.js


