# Bookstore E-Commerce - Mobile Technical Challenge

*Leia em / Read in: [English](#english) | [Português](#português)*

---

## English

### Overview
A Flutter-based mobile application simulating a bookstore e-commerce environment. This project was developed as a solution for a Mobile Development technical challenge, with a primary focus on UI/UX fidelity, state management, and responsive design across mobile and desktop viewports.

### Features
* **Product Discovery:** Dynamic carousel for featured books with custom viewport fractions.
* **Catalog Listing:** Best sellers grid with responsive layout adaptations.
* **Cart Management:** Addition, removal, and calculation of cart items.
* **Checkout Flow:** Order summary and localized price formatting.
* **Cross-Platform Responsiveness:** Mobile-first approach with geometric stabilization for tablets and web/desktop environments.

### Technical Architecture
The project adheres to separation of concerns and a feature-driven architecture:

1. **Responsive Layout Strategy:**
   * Implementation of `ConstrainedBox` to establish maximum width boundaries (`maxWidth`), preventing UI distortion on ultrawide monitors.
   * Usage of `MediaQuery` and mathematical clamping (`clamp()`) for vertical scaling, preserving image aspect ratios without hardcoded static heights.

2. **Data Abstraction:**
   * Data models are isolated from the UI layer.
   * Navigation passes domain objects directly to screens via constructor injection.
   * Current data fetching is handled via synchronous local mocks (JSON), architected to allow direct substitution with a REST API data provider layer in the future.

### Getting Started

**Prerequisites:**
* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* Android/iOS Emulator or Web Browser (Chrome/Edge)

**Installation:**
1. Clone the repository:
   ```bash
   git clone [https://github.com/your-username/repository-name.git](https://github.com/your-username/repository-name.git)
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

### Project Structure
```text
.
├── assets/
│    └── data/         # Local mock data (e.g., books.json)
├── docs/              # Project documentation and schemas (e.g., books_schema.md)
└── lib/
     ├── features/     # Feature-based UI modules (homepage, login, profile, shared)
     ├── services/     # Global application services (e.g., session_manager.dart)
     ├── main.dart     # Application entry point
```

---

## Português

### Visão Geral
Aplicativo mobile construído em Flutter que simula um ambiente de e-commerce para uma livraria. Este projeto foi desenvolvido como solução para um desafio técnico de Desenvolvimento Mobile, com foco primário em fidelidade de UI/UX, gerenciamento de estado e design responsivo abrangendo plataformas mobile e desktop.

### Funcionalidades
* **Descoberta de Produtos:** Carrossel dinâmico para livros em destaque com frações de visualização customizadas.
* **Listagem de Catálogo:** Grade de mais vendidos com adaptações de layout responsivo.
* **Gerenciamento de Carrinho:** Adição, remoção e cálculo de itens do carrinho.
* **Fluxo de Checkout:** Resumo do pedido e formatação de preços localizada.
* **Responsividade Multiplataforma:** Abordagem *mobile-first* com estabilização geométrica para tablets e ambientes web/desktop.

### Arquitetura Técnica
O projeto segue o princípio de separação de responsabilidades e uma arquitetura orientada a funcionalidades (Feature-First):

1. **Estratégia de Layout Responsivo:**
   * Implementação de `ConstrainedBox` para estabelecer limites de largura máxima (`maxWidth`), prevenindo distorção da UI em monitores ultrawide.
   * Uso de `MediaQuery` e restrição matemática (`clamp()`) para escalonamento vertical, preservando a proporção de imagens sem o uso de alturas estáticas fixas.

2. **Abstração de Dados:**
   * Modelos de dados estão isolados da camada de UI.
   * A navegação transfere objetos de domínio diretamente para as telas via injeção de dependência no construtor.
   * A obtenção de dados atual é feita através de mocks locais síncronos via JSON, estruturada de forma a permitir a substituição direta por uma camada de provedor de dados via API REST no futuro.

### Como Executar

**Pré-requisitos:**
* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* Emulador Android/iOS ou Navegador Web (Chrome/Edge)

**Instalação:**
1. Clone o repositório:
   ```bash
   git clone [https://github.com/seu-usuario/nome-do-repositorio.git](https://github.com/seu-usuario/nome-do-repositorio.git)
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo:
   ```bash
   flutter run
   ```

### Estrutura do Projeto
```text
.
├── assets/
│    └── data/         # Dados locais simulados (ex: books.json)
├── docs/              # Documentação do projeto e esquemas (ex: books_schema.md)
└── lib/
     ├── features/     # Módulos de UI baseados em funcionalidades (homepage, login, profile, shared)
     ├── services/     # Serviços globais da aplicação (ex: session_manager.dart)
     ├── main.dart     # Ponto de entrada da aplicação
```
