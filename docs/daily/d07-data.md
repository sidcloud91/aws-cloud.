# Day 07 – Data Layer

## Objectives
- Aurora Serverless v2 cluster (PostgreSQL)
- Parameter group + snapshot retention
- ElastiCache Redis cluster (auth token) for caching

## Tasks Checklist
- [ ] Terraform aurora module
- [ ] Terraform redis module
- [ ] Security groups (least exposure)
- [ ] Performance Insights enabled
- [ ] Outputs: writer endpoint, redis endpoint

## Copilot Prompts
```
Terraform Aurora Serverless v2 (engine=postgres, min/max capacity vars), enable performance_insights and backup window; parameter group with log_min_duration_statement.
```

## Validation
- Connectivity test (psql) (later)

## Notes / Findings
_(fill during execution)_

## Risks / Follow-Ups
- Add global database evaluation
