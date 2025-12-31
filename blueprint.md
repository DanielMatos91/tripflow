
# Blueprint: Reestruturação do Projeto de App de Motorista

## Visão Geral

O objetivo é refatorar a estrutura do projeto para seguir o layout padrão de um aplicativo Flutter. Isso resolverá os problemas de compilação, dependência e execução que estão ocorrendo devido a uma estrutura de projeto aninhada. O aplicativo é um MVP para um app de motorista, que requer autenticação e exibição de perfil via Firebase.

## Design e Estilo

*   **Arquitetura:** A ser definida, mas atualmente usa uma abordagem baseada em serviços para interações com o Firebase.
*   **Gerenciamento de Estado:** Utiliza `StreamBuilder` para reagir a mudanças no estado de autenticação do Firebase.
*   **Estilo Visual:** Usa o tema padrão do Material Design.

## Recursos Implementados

*   Integração com Firebase (Core, Auth, Firestore).
*   Estrutura de autenticação (Login/Cadastro).
*   Páginas de placeholder para Perfil e Viagens.
*   Navegação básica.

## Plano de Reestruturação Atual

1.  **Analisar a Estrutura de Arquivos:** Listar os arquivos dentro de `driver_app_mvp/lib` para garantir que todos os componentes da aplicação sejam movidos.
2.  **Migrar Arquivos de Código-Fonte:**
    *   Ler o conteúdo de cada arquivo Dart em `driver_app_mvp/lib/`.
    *   Escrever esses arquivos no diretório `lib/` na raiz do projeto.
3.  **Migrar Arquivos de Configuração:**
    *   Substituir `pubspec.yaml` da raiz pelo `driver_app_mvp/pubspec.yaml`.
    *   Substituir `analysis_options.yaml` da raiz pelo `driver_app_mvp/analysis_options.yaml`.
4.  **Limpar Arquivos Antigos:**
    *   Deletar o `lib/main.dart` original (aplicativo de contador).
    *   Remover recursivamente o diretório `driver_app_mvp`.
5.  **Reconstruir o Projeto:**
    *   Executar `flutter clean`.
    *   Executar `flutter pub get` para baixar as dependências corretas no contexto do projeto raiz.
6.  **Verificação Final:**
    *   Tentar executar o aplicativo com `flutter run` a partir da raiz do projeto.

