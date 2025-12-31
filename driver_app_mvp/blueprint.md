
# Visão Geral do Projeto: Driver App MVP

Este documento descreve o projeto de um aplicativo MVP (Minimum Viable Product) para motoristas de serviços de transfer, desenvolvido em Flutter com integração Firebase.

## Funcionalidades Implementadas

*   **Autenticação:**
    *   Login com email e senha.
    *   Criação de conta com nome, email e senha.
    *   Fluxo de redefinição de senha.
    *   Logout seguro.
*   **Banco de Dados (Firestore):**
    *   Criação e atualização automática de um documento de motorista na coleção `drivers` no momento do registro e login.
    *   O documento do motorista armazena `name`, `email`, `activeTripId`, `createdAt` e `updatedAt`.
*   **Interface do Usuário (UI):**
    *   **Tela de Login/Criar Conta:** Formulário para entrada de dados com validações.
    *   **Tela de Perfil:** Exibe as informações do motorista (nome e email) em tempo real, obtidas do Firestore. Contém botões para:
        *   Mudar a palavra-passe.
        *   Termos e Condições (placeholder).
        *   Terminar a sessão.
        *   Suporte técnico (placeholder).
        *   Chat com OPS (placeholder).
    *   **Navegação:**
        *   Bottom navigation bar com duas abas: "Viagens" e "Perfil".
        *   A aba "Viagens" leva a uma página de placeholder.
        *   O estado de autenticação do usuário (logado/deslogado) controla a tela que é exibida (tela de login ou tela principal do app).
    *   **Configurações (locais):**
        *   Toggle para "Ações automatizadas com base na posição do GPS".
        *   Seleção de tema (Claro/Escuro/Auto).

## Estrutura do Projeto

O projeto segue uma estrutura organizada para facilitar a manutenção e escalabilidade:

```
lib/
├── app.dart
├── main.dart
├── pages/
│   ├── login_page.dart
│   ├── profile_page.dart
│   └── trips_placeholder_page.dart
├── services/
│   ├── auth_service.dart
│   └── driver_service.dart
└── widgets/
    └── app_bottom_nav.dart
```

## Próximos Passos (Pós-MVP)

*   Implementar a funcionalidade completa da aba "Viagens", incluindo as seções "Próximos" e "Passados".
*   Criar a tela de detalhes da viagem.
*   Integrar um mapa (placeholder ou real, dependendo dos requisitos).
*   Salvar as preferências de GPS e tema do usuário.
*   Implementar as funcionalidades de "Termos e Condições", "Suporte" e "Chat".
