import { database } from "./database/func.js";
import { db } from "./database/db.js";
import { ref, get } from "firebase/database";

async function buscarUsuarios() {
  try {
    // coisinha pra ver o tempo que demora pra pegar dados no banco
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

// Testeee
await database.write("/oii", "funcionouuu");

buscarUsuarios();
