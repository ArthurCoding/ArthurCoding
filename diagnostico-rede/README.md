# Diagnóstico de Rede Wi-Fi para Windows (Batch)

Utilitário em Batch Script que reúne em um menu interativo os comandos de diagnóstico de rede mais usados no suporte técnico. Ele padroniza a coleta de informações da estação e reduz o tempo de atendimento em chamados de conectividade.

Não precisa instalar nada: usa só ferramentas nativas do Windows (`ipconfig`, `route`, `ping`, `netsh`, `xcopy`).

## Funções

| Opção | O que faz | Comandos |
|---|---|---|
| 1 | Configuração completa de IP de todos os adaptadores | `ipconfig /all` |
| 2 | Identifica o gateway padrão pela tabela de rotas e testa a resposta | `route print -4`, `ping` |
| 3 | Ping para um IP ou domínio informado pelo técnico | `ping -n 4` |
| 4 | Status da interface Wi-Fi e configuração de proxy | `netsh wlan show interfaces`, `netsh winhttp show proxy` |
| 5 | Limpa o cache DNS | `ipconfig /flushdns` |
| 6 | Gera um relatório de rede e salva na Área de Trabalho (`Logs_WiFi\wifi_diag_log.txt`) | `ipconfig`, `netsh`, `route`, `xcopy` |
| 7 | Executa os testes 1, 2, 4, 5 e 6 em sequência | — |

## Como usar

1. Baixe o arquivo `diagnostico-rede.bat`.
2. Dê dois cliques ou execute pelo Prompt de Comando.
3. Escolha a opção no menu (1 a 8).

A opção 5 (limpar cache DNS) pode exigir que o Prompt seja aberto como administrador.

## Caso de uso

Em um chamado do tipo "a internet não funciona", a opção 7 coleta em poucos segundos IP, gateway, estado do Wi-Fi e proxy, e já deixa um relatório pronto para anexar ao chamado.

## Manutenção

Mantido por Arthur Saraiva de Souza · [LinkedIn](https://www.linkedin.com/in/arthur-saraiva-de-souza-4b6a0b280/)
