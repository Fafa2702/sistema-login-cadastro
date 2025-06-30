import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  // Teste Firebase: escrever
  await database.write("/oii", "funcionouuu");

  // Teste Firebase: ler
  try {
    const before = Date.now();
    const dbRef = ref(db, "/ping");
    const snapshot = await get(dbRef);
    const after = Date.now();
    const ping = after - before;

    if (snapshot.exists()) {
      const data = snapshot.val();
      console.log("Sucesso ao logar");
      console.log(data, ping, "ms de ping");
    } else {
      console.log("Dado inexistente");
    }
  } catch (e) {
    console.error("Erro ao buscar dados Firebase:", e);
  }

  // Teste Prisma
  const users = await prisma.usuario.findMany();
  console.log("Usuários:", users);
}
