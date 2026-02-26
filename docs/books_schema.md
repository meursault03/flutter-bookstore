# Schema JSON dos Livros

Arquivo fonte: `assets/data/books.json`

## Campos

| Campo        | Tipo     | Obrigatório | Restrições                               | Descrição                          |
|-------------|----------|-------------|------------------------------------------|------------------------------------|
| `id`        | `int`    | Sim         | Único, sequencial a partir de 0          | Identificador único do livro       |
| `authorName`| `String` | Sim         | Não vazio                                | Nome completo do autor             |
| `price`     | `double` | Sim         | Valor positivo em BRL (R$)               | Preço do livro                     |
| `title`     | `String` | Sim         | Não vazio                                | Título do livro                    |
| `description`| `String`| Sim         | Não vazio                                | Sinopse breve do livro             |
| `image`     | `String` | Sim         | URL válida (HTTPS)                       | URL da imagem de capa              |
| `categoria` | `String` | Sim         | Uma das categorias listadas abaixo       | Categoria do livro                 |
| `estoque`   | `int`    | Sim         | Não negativo                             | Quantidade disponível em estoque   |

## Categorias (5)

1. Ficção e Literatura
2. Filosofia e Sociologia
3. Ciências Exatas e Tecnologia
4. Fantasia e Ficção Científica
5. Estratégia e Negócios

## Exemplo

```json
{
  "id": 0,
  "authorName": "Fiódor Dostoiévski",
  "price": 85.90,
  "title": "Crime e Castigo",
  "description": "A angústia mental e os dilemas morais de um ex-estudante empobrecido em São Petersburgo.",
  "image": "https://covers.openlibrary.org/b/id/13947662-L.jpg",
  "categoria": "Ficção e Literatura",
  "estoque": 15
}
```
