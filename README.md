# 📦 E-Commerce Logistics & Performance Analytics (Olist)

<p align="center">
  <img src="https://img.shields.io/badge/Status-Em%20Desenvolvimento-FF8C00?style=for-the-badge" alt="Status" />
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=Tableau&logoColor=white" alt="Tableau" />
</p>

## 🎯 O Problema de Negócio
A logística é o coração do e-commerce. Este projeto analisa a malha logística e o comportamento do consumidor brasileiro utilizando o dataset público da **Olist** (com mais de 100 mil pedidos reais). O objetivo é diagnosticar gargalos de entrega, calcular o SLA (Service Level Agreement) das transportadoras e entender o impacto dos atrasos na satisfação final do cliente (CSAT).

## 🏗️ Arquitetura de Dados (Concluída)
Para garantir performance e confiabilidade (Single Source of Truth), este projeto foi estruturado em um pipeline completo de ponta a ponta:

1. **Extração e Limpeza (Python/Pandas):** Ingestão de 9 tabelas brutas, tratamento de nulos, remoção de anomalias logísticas e *casting* de datas.
2. **Data Warehouse (PostgreSQL):** Modelagem relacional criando Tabelas Fato e Dimensões DDL com tipagem estrita.
3. **Carga Automatizada (ELT):** Script Python utilizando `SQLAlchemy` e variáveis de ambiente (`.env`) para popular o banco de forma segura e reproduzível.
4. **Camada Semântica (SQL Views):** Criação de *Business Views* diretamente no banco de dados para cálculo de métricas complexas (como dias de atraso e cruzamento de rotas), poupando processamento da ferramenta de BI.

## 📊 Visualização de Dados (Próximos Passos)
O painel executivo interativo será construído no **Tableau**, focado em:
* KPIs Financeiros e de Volumetria.
* Mapa Geoespacial de Rotas e Densidade de Atrasos.
* Análise de Quadrantes: Dispersão entre Tempo de Entrega vs. Nota de Avaliação do Consumidor.

---
*Projeto em desenvolvimento por Márcio Pierre para portfólio de Data Analytics / B.I. Sênior.*