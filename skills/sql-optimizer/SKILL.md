---
name: sql-optimizer
description: >-
  Optimize SQL queries for better performance in Redshift, PostgreSQL, and MySQL.
  Use when working with slow queries, analyzing query plans, or improving database performance.
allowed-tools: Bash, Read, Write
argument-hint: "<query-or-file>"
---

# SQL Optimizer

Techniques for optimizing SQL queries across different databases.

## Redshift Optimization

- Use DISTKEY and SORTKEY appropriately
- Avoid SELECT * - specify columns
- Use column-oriented storage advantages
- Consider using ANALYZE to update statistics
- Use appropriate compression (ENCODE)

## PostgreSQL Optimization

- Create appropriate indexes
- Use EXPLAIN ANALYZE to understand query plans
- Consider partial indexes for filtered queries
- Use CTEs judiciously (they're optimization fences)
- Vacuum and analyze regularly

## General Tips

- Filter early (push predicates down)
- Join on indexed columns
- Avoid functions in WHERE clauses
- Use appropriate data types
- Consider materialized views for complex aggregations
