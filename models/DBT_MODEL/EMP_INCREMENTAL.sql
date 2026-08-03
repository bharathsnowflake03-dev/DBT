{{
    config(
        materialized = 'incremental',
        unique_key = 'EMP_ID',
        incremental_strategy = 'merge'
    )
}}

SELECT
    EMP_ID,
    EMP_NAME,
    DEPARTMENT,
    SALARY,
    UPDATED_AT
FROM EMP

{% if is_incremental() %}

WHERE UPDATED_AT > (
    SELECT MAX(UPDATED_AT)
    FROM {{ this }}
)

{% endif %}