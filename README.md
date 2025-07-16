# Silvana Perfumes - Supabase

Este repositório contém os scripts SQL necessários para configurar o banco de dados do projeto Silvana Perfumes no Supabase.

## Instruções para criar a tabela de perfumes

Como o modo somente leitura está ativado na sua conta do Supabase, você precisará executar o script SQL manualmente através do Editor SQL no Dashboard do Supabase.

Siga os passos abaixo:

1. Acesse o [Dashboard do Supabase](https://supabase.com/dashboard)
2. Selecione seu projeto
3. No menu lateral, clique em "SQL Editor"
4. Clique em "New Query"
5. Copie e cole o conteúdo do arquivo [create_perfumes_table.sql](https://github.com/ralphdanezin/silvana-perfumes-supabase/blob/main/create_perfumes_table.sql) no editor
6. Clique em "Run" para executar o script

## Estrutura da tabela de perfumes

A tabela `perfumes` contém os seguintes campos:

- `id`: Identificador único do perfume (gerado automaticamente)
- `nome`: Nome do perfume
- `marca`: Marca do perfume
- `descricao`: Descrição do perfume
- `preco`: Preço do perfume
- `estoque`: Quantidade em estoque
- `imagem_url`: URL da imagem do perfume
- `created_at`: Data de criação do registro

## Políticas de segurança

O script também configura as seguintes políticas de segurança (RLS):

- Leitura: Permitida para todos (incluindo usuários anônimos)
- Inserção, atualização e exclusão: Permitidas apenas para usuários autenticados

## Dados de exemplo

O script inclui a inserção de alguns dados de exemplo para você começar a testar o sistema.

## Suporte

Se você tiver alguma dúvida ou precisar de ajuda, abra uma issue neste repositório.
