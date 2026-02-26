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
The project adheres to separation of concerns and a feature-driven architecture.

### Tested Environments
| Platform | Device / Resolution |
|----------|-------------------|
| Android  | Pixel 5 (Android 13) |
| Web      | 1080p (1920×1080) |
| Web      | QHD (2560×1440) |

> Other devices and resolutions may work but have not been formally validated.

### Getting Started

**Prerequisites:**
* [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x or later
* Dart SDK 3.x (bundled with Flutter)
* Android Studio or VS Code with the Flutter and Dart extensions
* Android Emulator (API 30+) or a physical device, **or** Chrome/Edge for web

**Installation:**
1. Clone the repository:
   ```bash
   git clone https://github.com/meursault03/flutter-bookstore
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   # Android (emulator or physical device)
   flutter run

   # Web (Chrome)
   flutter run -d chrome
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
O projeto segue o princípio de separação de responsabilidades e uma arquitetura orientada a funcionalidades (Feature-First).

### Ambientes Testados
| Plataforma | Dispositivo / Resolução |
|------------|------------------------|
| Android    | Pixel 5 (Android 13) |
| Web        | 1080p (1920×1080) |
| Web        | QHD (2560×1440) |

> Outros dispositivos e resoluções podem funcionar, mas não foram validados formalmente.

### Como Executar

**Pré-requisitos:**
* [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x ou superior
* Dart SDK 3.x (incluso no Flutter)
* Android Studio ou VS Code com as extensões Flutter e Dart
* Emulador Android (API 30+) ou dispositivo físico, **ou** Chrome/Edge para web

**Instalação:**
1. Clone o repositório:
   ```bash
   git clone https://github.com/meursault03/flutter-bookstore
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo:
   ```bash
   # Android (emulador ou dispositivo físico)
   flutter run

   # Web (Chrome)
   flutter run -d chrome
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