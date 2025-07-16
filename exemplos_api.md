# Exemplos de uso da API do Supabase

Este documento contém exemplos de como usar a API do Supabase para acessar a tabela de perfumes usando JavaScript.

## Configuração inicial

Primeiro, você precisa inicializar o cliente do Supabase com sua URL e chave anônima:

```javascript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://syynrboravajesntfcrs.supabase.co'
const supabaseKey = 'sua-chave-anonima' // Substitua pela sua chave anônima
const supabase = createClient(supabaseUrl, supabaseKey)
```

## Buscar todos os perfumes

```javascript
async function buscarPerfumes() {
  const { data, error } = await supabase
    .from('perfumes')
    .select('*')
  
  if (error) {
    console.error('Erro ao buscar perfumes:', error)
    return
  }
  
  console.log('Perfumes:', data)
  return data
}
```

## Buscar um perfume específico por ID

```javascript
async function buscarPerfumePorId(id) {
  const { data, error } = await supabase
    .from('perfumes')
    .select('*')
    .eq('id', id)
    .single()
  
  if (error) {
    console.error(`Erro ao buscar perfume com ID ${id}:`, error)
    return
  }
  
  console.log('Perfume encontrado:', data)
  return data
}
```

## Buscar perfumes com filtros

```javascript
async function buscarPerfumesFiltrados(marca, precoMaximo) {
  const query = supabase
    .from('perfumes')
    .select('*')
  
  if (marca) {
    query.eq('marca', marca)
  }
  
  if (precoMaximo) {
    query.lte('preco', precoMaximo)
  }
  
  const { data, error } = await query
  
  if (error) {
    console.error('Erro ao buscar perfumes filtrados:', error)
    return
  }
  
  console.log('Perfumes filtrados:', data)
  return data
}
```

## Inserir um novo perfume (requer autenticação)

```javascript
async function inserirPerfume(perfume) {
  // Certifique-se de que o usuário está autenticado antes de chamar esta função
  const { data, error } = await supabase
    .from('perfumes')
    .insert([
      {
        nome: perfume.nome,
        marca: perfume.marca,
        descricao: perfume.descricao,
        preco: perfume.preco,
        estoque: perfume.estoque,
        imagem_url: perfume.imagem_url
      }
    ])
    .select()
  
  if (error) {
    console.error('Erro ao inserir perfume:', error)
    return
  }
  
  console.log('Perfume inserido:', data)
  return data
}
```

## Atualizar um perfume existente (requer autenticação)

```javascript
async function atualizarPerfume(id, dadosAtualizados) {
  // Certifique-se de que o usuário está autenticado antes de chamar esta função
  const { data, error } = await supabase
    .from('perfumes')
    .update(dadosAtualizados)
    .eq('id', id)
    .select()
  
  if (error) {
    console.error(`Erro ao atualizar perfume com ID ${id}:`, error)
    return
  }
  
  console.log('Perfume atualizado:', data)
  return data
}
```

## Excluir um perfume (requer autenticação)

```javascript
async function excluirPerfume(id) {
  // Certifique-se de que o usuário está autenticado antes de chamar esta função
  const { error } = await supabase
    .from('perfumes')
    .delete()
    .eq('id', id)
  
  if (error) {
    console.error(`Erro ao excluir perfume com ID ${id}:`, error)
    return false
  }
  
  console.log(`Perfume com ID ${id} excluído com sucesso`)
  return true
}
```

## Autenticação de usuários

Para operações que requerem autenticação (inserir, atualizar, excluir), você precisa primeiro autenticar o usuário:

```javascript
async function fazerLogin(email, senha) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: email,
    password: senha
  })
  
  if (error) {
    console.error('Erro ao fazer login:', error)
    return null
  }
  
  console.log('Usuário autenticado:', data)
  return data
}

async function fazerLogout() {
  const { error } = await supabase.auth.signOut()
  
  if (error) {
    console.error('Erro ao fazer logout:', error)
    return false
  }
  
  console.log('Logout realizado com sucesso')
  return true
}
```

## Escutando mudanças em tempo real

Você também pode usar o recurso de tempo real do Supabase para receber atualizações quando os dados mudarem:

```javascript
function escutarMudancasPerfumes() {
  const subscription = supabase
    .channel('public:perfumes')
    .on('postgres_changes', { event: '*', schema: 'public', table: 'perfumes' }, (payload) => {
      console.log('Mudança detectada:', payload)
      // Atualize sua interface de usuário aqui
    })
    .subscribe()
  
  // Retorne a subscription para que você possa cancelá-la mais tarde
  return subscription
}

// Para cancelar a subscription quando não precisar mais dela:
function cancelarEscuta(subscription) {
  supabase.removeChannel(subscription)
}
```

Estes exemplos devem ajudar você a começar a usar a API do Supabase com sua tabela de perfumes. Lembre-se de substituir `'sua-chave-anonima'` pela chave anônima real do seu projeto Supabase.