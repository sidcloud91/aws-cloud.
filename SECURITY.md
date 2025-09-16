# Security Workflow Documentation

## Overview

This repository implements enterprise-grade security practices to prevent secrets, credentials, and sensitive data from being committed to version control.

## Security Tools Implemented

### 1. Git-Secrets (AWS Official Tool)
- **Purpose**: Prevents AWS credentials and other secrets from being committed
- **Installation**: `brew install git-secrets` (installed automatically)
- **Configuration**:
  - AWS patterns registered automatically
  - Custom patterns for private keys, passwords, and tokens
  - Runs on every commit, commit message, and merge

### 2. Pre-commit Framework
- **Purpose**: Multi-hook framework for comprehensive code quality and security
- **Installation**: `pip3 install pre-commit` (installed automatically)
- **Configuration**: `.pre-commit-config.yaml`
- **Hooks Included**:
  - Built-in security checks (detect-private-key, check-merge-conflict)
  - Detect-secrets integration
  - Terraform validation and formatting
  - YAML, JSON, and Markdown linting
  - Shell script validation

### 3. Detect-Secrets (Yelp's Enterprise Tool)
- **Purpose**: Advanced secret detection with machine learning
- **Installation**: `pip3 install detect-secrets` (installed automatically)
- **Configuration**: `.secrets.baseline`
- **Features**:
  - Multiple detection algorithms
  - False positive management
  - Baseline tracking for existing secrets

### 4. Comprehensive .gitignore
- **Purpose**: Prevent sensitive files from being tracked
- **Coverage**:
  - AWS credentials and configurations
  - Private keys and certificates
  - Environment files and secrets
  - Terraform state files
  - Database configurations
  - API keys and tokens

## Security Workflow

### Pre-commit Checks (Automatic)
When you attempt to commit code, the following checks run automatically:

1. **File Security Checks**:
   - Trailing whitespace removal
   - Large file detection (>500KB blocked)
   - Private key detection
   - Merge conflict detection

2. **Secret Detection**:
   - Git-secrets scan for AWS credentials
   - Detect-secrets scan for various secret types
   - Custom patterns for passwords and tokens

3. **Code Quality**:
   - Terraform formatting and validation
   - YAML/JSON syntax validation
   - Markdown linting
   - Shell script validation

### Manual Security Checks

#### Scan for Secrets
```bash
# Run detect-secrets on all files
detect-secrets scan --all-files

# Run git-secrets on all files
git secrets --scan

# Update baseline (run after legitimate secrets are handled)
detect-secrets scan --all-files --force-use-all-plugins > .secrets.baseline
```

#### Terraform Security
```bash
# Run TFSec for security analysis
docker run --rm -v "$(pwd):/src" aquasec/tfsec /src

# Run Checkov for additional security checks
pip install checkov
checkov -d .
```

## Handling False Positives

### Detect-Secrets
If detect-secrets flags a false positive:

1. Add to baseline:
   ```bash
   detect-secrets scan --update .secrets.baseline
   ```

2. Or exclude specific patterns in `.pre-commit-config.yaml`

### Git-Secrets
If git-secrets flags a false positive:

1. Add allowed pattern:
   ```bash
   git secrets --add --allowed 'pattern-to-allow'
   ```

## Emergency Procedures

### If Secrets Are Committed

1. **Stop immediately** - Don't push if not yet pushed
2. **Rotate the compromised secrets** immediately
3. **Remove from git history**:
   ```bash
   # For recent commits
   git reset --soft HEAD~1
   git reset HEAD

   # For older commits (use with caution)
   git filter-branch --force --index-filter \
   'git rm --cached --ignore-unmatch path/to/secret/file' \
   --prune-empty --tag-name-filter cat -- --all
   ```
4. **Update baseline** and **test security hooks**
5. **Force push** (if already pushed and history rewritten)

### If Hooks Are Bypassed

Pre-commit hooks can be bypassed with `--no-verify`. If this happens:

1. **Immediately scan the repository**:
   ```bash
   detect-secrets scan --all-files
   git secrets --scan
   ```

2. **Check what was committed**:
   ```bash
   git log --oneline -10
   git show [commit-hash]
   ```

3. **Follow emergency procedures** if secrets found

## Best Practices

### For Developers

1. **Never use `--no-verify`** flag unless absolutely necessary
2. **Store secrets in environment variables** or secret management systems
3. **Use `.tfvars.example`** files instead of committing actual `.tfvars`
4. **Regularly update security tools**:
   ```bash
   pre-commit autoupdate
   pip install --upgrade detect-secrets
   ```

### For Repository Maintenance

1. **Regular security audits**:
   ```bash
   # Weekly/monthly full scan
   detect-secrets scan --all-files --force-use-all-plugins
   git secrets --scan
   ```

2. **Keep baselines updated**:
   ```bash
   detect-secrets scan --all-files --force-use-all-plugins > .secrets.baseline
   ```

3. **Review and update patterns** regularly
4. **Train team members** on security practices

## Integration with CI/CD

### GitHub Actions Example
```yaml
- name: Run Security Checks
  run: |
    pip install detect-secrets
    detect-secrets scan --baseline .secrets.baseline
    git secrets --scan
```

### GitLab CI Example
```yaml
security_scan:
  script:
    - pip install detect-secrets
    - detect-secrets scan --baseline .secrets.baseline
    - git secrets --scan
```

## Tools Comparison

| Tool | Strength | Use Case |
|------|----------|----------|
| **git-secrets** | AWS official, fast | AWS credentials, basic patterns |
| **detect-secrets** | Advanced ML, enterprise | Complex secrets, false positive management |
| **pre-commit** | Comprehensive, extensible | Overall code quality and security |
| **TFSec** | Terraform-specific | Infrastructure security |
| **Checkov** | Multi-format security | Comprehensive security scanning |

## Support and Troubleshooting

### Common Issues

1. **Hook failures**: Check `.pre-commit-config.yaml` syntax
2. **False positives**: Update baselines or add exclusions
3. **Performance**: Exclude large binary files in configurations

### Getting Help

- Git-secrets: https://github.com/awslabs/git-secrets
- Pre-commit: https://pre-commit.com/
- Detect-secrets: https://github.com/Yelp/detect-secrets
- Internal team: [Add your team's contact info]

## Compliance

This security workflow helps ensure compliance with:
- SOC 2 Type II requirements
- PCI DSS standards
- GDPR data protection
- Company security policies
- Industry best practices

---

**Remember**: Security is everyone's responsibility. When in doubt, ask the security team!
