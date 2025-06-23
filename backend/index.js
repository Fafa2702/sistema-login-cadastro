import express from 'express';
import { database } from './database/func.js';
import { db } from './database/db.js';
import { ref, get } from 'firebase/database';
import cadastroRoutes from './controllers/cadastro.js';

const app = express();
const PORT = 3000;

app.use(express.json());
app.use('/usuario', cadastroRoutes); // <- conecta o controller

app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});

// Firebase teste
await database.write("/oii", "funcionouuu");

async function buscarUsuarios() {
  try {
    const before = Date.now();
    const dbRef = ref(db, "/ping");
    const snapshot = await get(dbRef);
    const after = Date.now();
    const ping = after - before;

    if (!snapshot.exists()) {
      console.log("Dado inexistente");
      return;
    }

    const data = snapshot.val();
    console.log("Sucesso ao logar");
    console.log(data, ping);
  } catch (e) {
    console.log("Erro ao buscar dados:");
    console.error(e);
  }
}

buscarUsuarios();

// Testeee
await database.write("/oii", "funcionouuu");

buscarUsuarios();


import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const users = await prisma.usuario.findMany();
  console.log("Usuários:", users);
}

main();
