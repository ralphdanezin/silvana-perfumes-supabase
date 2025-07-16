# Integrando o Supabase com uma Aplicação Web

Este guia mostra como integrar o Supabase com diferentes tipos de aplicações web para o projeto Silvana Perfumes.

## Integração com React

### Instalação

```bash
npm install @supabase/supabase-js
```

### Configuração

Crie um arquivo `supabaseClient.js` na pasta `src` do seu projeto:

```javascript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://syynrboravajesntfcrs.supabase.co'
const supabaseKey = 'sua-chave-anonima' // Substitua pela sua chave anônima

export const supabase = createClient(supabaseUrl, supabaseKey)
```

### Exemplo de componente para listar perfumes

```jsx
import React, { useEffect, useState } from 'react'
import { supabase } from './supabaseClient'

function ListaPerfumes() {
  const [perfumes, setPerfumes] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    async function buscarPerfumes() {
      try {
        setLoading(true)
        
        const { data, error } = await supabase
          .from('perfumes')
          .select('*')
          .order('nome', { ascending: true })
        
        if (error) {
          throw error
        }
        
        setPerfumes(data || [])
      } catch (error) {
        console.error('Erro ao buscar perfumes:', error)
        setError('Não foi possível carregar os perfumes')
      } finally {
        setLoading(false)
      }
    }
    
    buscarPerfumes()
  }, [])

  if (loading) return <div>Carregando...</div>
  if (error) return <div>Erro: {error}</div>

  return (
    <div>
      <h2>Catálogo de Perfumes</h2>
      <div className="perfumes-grid">
        {perfumes.length === 0 ? (
          <p>Nenhum perfume encontrado</p>
        ) : (
          perfumes.map((perfume) => (
            <div key={perfume.id} className="perfume-card">
              {perfume.imagem_url && (
                <img 
                  src={perfume.imagem_url} 
                  alt={perfume.nome} 
                  className="perfume-image" 
                />
              )}
              <h3>{perfume.nome}</h3>
              <p className="marca">{perfume.marca}</p>
              <p className="descricao">{perfume.descricao}</p>
              <p className="preco">R$ {perfume.preco.toFixed(2)}</p>
              <p className="estoque">
                {perfume.estoque > 0 
                  ? `${perfume.estoque} em estoque` 
                  : 'Fora de estoque'}
              </p>
            </div>
          ))
        )}
      </div>
    </div>
  )
}

export default ListaPerfumes
```

## Integração com Vue.js

### Instalação

```bash
npm install @supabase/supabase-js
```

### Configuração

Crie um arquivo `supabase.js` na pasta `src` do seu projeto:

```javascript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://syynrboravajesntfcrs.supabase.co'
const supabaseKey = 'sua-chave-anonima' // Substitua pela sua chave anônima

export const supabase = createClient(supabaseUrl, supabaseKey)
```

### Exemplo de componente para listar perfumes

```vue
<template>
  <div>
    <h2>Catálogo de Perfumes</h2>
    <div v-if="loading">Carregando...</div>
    <div v-else-if="error">Erro: {{ error }}</div>
    <div v-else class="perfumes-grid">
      <div v-if="perfumes.length === 0">
        <p>Nenhum perfume encontrado</p>
      </div>
      <div v-else>
        <div 
          v-for="perfume in perfumes" 
          :key="perfume.id" 
          class="perfume-card"
        >
          <img 
            v-if="perfume.imagem_url" 
            :src="perfume.imagem_url" 
            :alt="perfume.nome" 
            class="perfume-image" 
          />
          <h3>{{ perfume.nome }}</h3>
          <p class="marca">{{ perfume.marca }}</p>
          <p class="descricao">{{ perfume.descricao }}</p>
          <p class="preco">R$ {{ perfume.preco.toFixed(2) }}</p>
          <p class="estoque">
            {{ perfume.estoque > 0 
              ? `${perfume.estoque} em estoque` 
              : 'Fora de estoque' }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { supabase } from '../supabase'

export default {
  name: 'ListaPerfumes',
  setup() {
    const perfumes = ref([])
    const loading = ref(true)
    const error = ref(null)

    async function buscarPerfumes() {
      try {
        loading.value = true
        
        const { data, error: supabaseError } = await supabase
          .from('perfumes')
          .select('*')
          .order('nome', { ascending: true })
        
        if (supabaseError) {
          throw supabaseError
        }
        
        perfumes.value = data || []
      } catch (err) {
        console.error('Erro ao buscar perfumes:', err)
        error.value = 'Não foi possível carregar os perfumes'
      } finally {
        loading.value = false
      }
    }

    onMounted(() => {
      buscarPerfumes()
    })

    return {
      perfumes,
      loading,
      error
    }
  }
}
</script>

<style scoped>
.perfumes-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}

.perfume-card {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.perfume-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 4px;
}

.preco {
  font-weight: bold;
  color: #e63946;
}
</style>
```

## Integração com HTML, CSS e JavaScript puro

Se você estiver criando um site simples sem frameworks, pode usar o Supabase diretamente no seu HTML:

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Silvana Perfumes - Catálogo</title>
  <style>
    .perfumes-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
    }
    
    .perfume-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .perfume-image {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 4px;
    }
    
    .preco {
      font-weight: bold;
      color: #e63946;
    }
  </style>
</head>
<body>
  <h1>Silvana Perfumes</h1>
  
  <div id="app">
    <h2>Catálogo de Perfumes</h2>
    <div id="loading">Carregando...</div>
    <div id="error" style="display: none;"></div>
    <div id="perfumes-container" class="perfumes-grid"></div>
  </div>

  <script src="https://unpkg.com/@supabase/supabase-js@2"></script>
  <script>
    // Inicializar o cliente Supabase
    const supabaseUrl = 'https://syynrboravajesntfcrs.supabase.co';
    const supabaseKey = 'sua-chave-anonima'; // Substitua pela sua chave anônima
    const supabase = supabase.createClient(supabaseUrl, supabaseKey);
    
    // Elementos do DOM
    const loadingEl = document.getElementById('loading');
    const errorEl = document.getElementById('error');
    const perfumesContainer = document.getElementById('perfumes-container');
    
    // Função para buscar e exibir perfumes
    async function carregarPerfumes() {
      try {
        // Mostrar loading
        loadingEl.style.display = 'block';
        errorEl.style.display = 'none';
        perfumesContainer.style.display = 'none';
        
        // Buscar dados do Supabase
        const { data, error } = await supabase
          .from('perfumes')
          .select('*')
          .order('nome', { ascending: true });
        
        if (error) throw error;
        
        // Esconder loading
        loadingEl.style.display = 'none';
        perfumesContainer.style.display = 'grid';
        
        // Verificar se há perfumes
        if (!data || data.length === 0) {
          perfumesContainer.innerHTML = '<p>Nenhum perfume encontrado</p>';
          return;
        }
        
        // Renderizar perfumes
        perfumesContainer.innerHTML = data.map(perfume => `
          <div class="perfume-card">
            ${perfume.imagem_url ? `
              <img 
                src="${perfume.imagem_url}" 
                alt="${perfume.nome}" 
                class="perfume-image" 
              />
            ` : ''}
            <h3>${perfume.nome}</h3>
            <p class="marca">${perfume.marca}</p>
            <p class="descricao">${perfume.descricao}</p>
            <p class="preco">R$ ${parseFloat(perfume.preco).toFixed(2)}</p>
            <p class="estoque">
              ${perfume.estoque > 0 
                ? `${perfume.estoque} em estoque` 
                : 'Fora de estoque'}
            </p>
          </div>
        `).join('');
        
      } catch (err) {
        // Mostrar erro
        console.error('Erro ao carregar perfumes:', err);
        loadingEl.style.display = 'none';
        errorEl.style.display = 'block';
        errorEl.textContent = 'Erro ao carregar perfumes. Por favor, tente novamente.';
      }
    }
    
    // Carregar perfumes quando a página carregar
    document.addEventListener('DOMContentLoaded', carregarPerfumes);
  </script>
</body>
</html>
```

## Dicas para produção

1. **Segurança**: Nunca exponha sua chave de serviço (service_role) no frontend. Use apenas a chave anônima para aplicações frontend.

2. **Variáveis de ambiente**: Em projetos React ou Vue, armazene as chaves do Supabase em variáveis de ambiente:
   - Para React: Crie um arquivo `.env.local` com `REACT_APP_SUPABASE_URL` e `REACT_APP_SUPABASE_ANON_KEY`
   - Para Vue: Crie um arquivo `.env.local` com `VUE_APP_SUPABASE_URL` e `VUE_APP_SUPABASE_ANON_KEY`

3. **Autenticação**: Para operações de escrita (inserir, atualizar, excluir), implemente um sistema de autenticação usando o Supabase Auth.

4. **Otimização de consultas**: Use `.select()` para buscar apenas as colunas necessárias, reduzindo o tamanho da resposta.

5. **Tratamento de erros**: Sempre implemente tratamento de erros adequado para lidar com falhas na API.

6. **Tempo real**: Considere usar os recursos de tempo real do Supabase para manter sua interface atualizada automaticamente quando os dados mudarem.