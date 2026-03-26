-- DDL: Camada Semântica (

CREATE OR REPLACE VIEW vw_fato_vendas_completas AS
SELECT 
    -- 1. Chaves
    o.order_id AS id_pedido,
    o.customer_id AS id_cliente,
    i.product_id AS id_produto,
    i.seller_id AS id_vendedor,
    
    -- 2. Dimensões de Tempo
    o.order_purchase_timestamp AS data_compra,
    o.order_approved_at AS data_aprovacao,
    o.order_delivered_carrier_date AS data_postagem,
    o.order_delivered_customer_date AS data_entrega_real,
    o.order_estimated_delivery_date AS data_entrega_estimada,
    
    -- 3. Métricas de Logística (SLA)
    DATE_PART('day', o.order_delivered_customer_date - o.order_purchase_timestamp) AS dias_para_entrega,
    DATE_PART('day', o.order_estimated_delivery_date - o.order_delivered_customer_date) AS saldo_dias_prazo,
    
    -- 4. Dimensões Geográficas
    c.customer_city AS cidade_cliente,
    c.customer_state AS estado_cliente,
    s.seller_city AS cidade_vendedor,
    s.seller_state AS estado_vendedor,
    
    -- 5. Dimensões de Produto 
    COALESCE(t.product_category_name_english, p.product_category_name, 'Outros') AS categoria_produto,
    
    -- 6. Métricas Financeiras
    i.price AS valor_produto,
    i.freight_value AS valor_frete,
    (i.price + i.freight_value) AS valor_total_item,
    
    -- 7. Satisfação do Cliente
    r.review_score AS nota_avaliacao

FROM orders o
-- Relacionamento com os Itens do Pedido
INNER JOIN order_items i ON o.order_id = i.order_id
-- Relacionamento com Clientes
LEFT JOIN customers c ON o.customer_id = c.customer_id
-- Relacionamento com Vendedores
LEFT JOIN sellers s ON i.seller_id = s.seller_id
-- Relacionamento com Produtos e Tradução
LEFT JOIN products p ON i.product_id = p.product_id
LEFT JOIN category_translation t ON p.product_category_name = t.product_category_name
-- Relacionamento com Avaliações
LEFT JOIN order_reviews r ON o.order_id = r.order_id

-- Filtra apenas pedidos que realmente geraram receita e saíram do estoque
WHERE o.order_status NOT IN ('canceled', 'unavailable');