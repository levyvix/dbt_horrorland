{% macro is_valid_email(column_name) %}
    case
        when regexp_like({{ column_name }}, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
            and length({{ column_name }}) - length(regexp_replace({{ column_name }}, '@', '')) = 1
            and exists (
                select 1
                from {{ ref('valid_domains') }}
                where {{ column_name }} like '%' || domain
            )
        then true
        else false
    end
{% endmacro %}