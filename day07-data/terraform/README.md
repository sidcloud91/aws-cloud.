# Day 07 - Database and Caching Layer

## Aurora Serverless v2 and ElastiCache Redis

Enterprise database configuration with caching layer.

### Components:
- Aurora Serverless v2 (PostgreSQL)
- ElastiCache Redis cluster
- Parameter groups and option groups
- Backup and maintenance configurations

### Features:
- Performance Insights enabled
- Encryption at rest and in transit
- Multi-AZ deployment
- Automated backups

### Files to implement:
- `aurora.tf` - Aurora cluster configuration
- `redis.tf` - ElastiCache setup
- `parameter-groups.tf` - Custom parameters
- `security.tf` - Database security groups

*Database implementation for Day 07.*
