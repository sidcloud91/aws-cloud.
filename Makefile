# AWS Cloud Learning Journey Makefile
# Provides common operations for the 14-day learning plan

.PHONY: help status init plan apply destroy clean progress day1 day11 eks-config

# Default target
help:
	@echo "AWS Cloud Learning Journey - Available Commands:"
	@echo ""
	@echo "  📊 Progress & Status:"
	@echo "    make status     - Show overall progress and current day"
	@echo "    make progress   - Open progress tracker"
	@echo ""
	@echo "  🏗️  Infrastructure Operations:"
	@echo "    make init DAY=XX       - Initialize Terraform for specific day"
	@echo "    make plan DAY=XX       - Plan Terraform changes for specific day"
	@echo "    make apply DAY=XX      - Apply Terraform for specific day"
	@echo "    make destroy DAY=XX    - Destroy resources for specific day"
	@echo ""
	@echo "  🚀 Quick Starts:"
	@echo "    make day1       - Initialize Day 1 (foundations)"
	@echo "    make day11      - Setup Day 11 (EKS cluster)"
	@echo "    make eks-config - Configure kubectl for EKS"
	@echo ""
	@echo "  🧹 Utilities:"
	@echo "    make clean      - Clean Terraform temp files"
	@echo "    make lint       - Run tflint on all Terraform"
	@echo "    make validate   - Validate all Terraform configurations"
	@echo ""
	@echo "  📖 Documentation:"
	@echo "    make docs       - Generate/update documentation"
	@echo ""
	@echo "Usage Examples:"
	@echo "  make init DAY=01"
	@echo "  make plan DAY=02"
	@echo "  make apply DAY=11"

status:
	@echo "🎯 AWS Cloud Learning Journey Status"
	@echo "=================================="
	@echo "Start Date: September 11, 2025"
	@echo "Current Date: $$(date +'%Y-%m-%d')"
	@echo ""
	@echo "📁 Day-wise Progress:"
	@for day in $$(seq -w 1 14); do \
		if [ -d "day$$day-*" ]; then \
			dir=$$(ls -d day$$day-* 2>/dev/null | head -1); \
			if [ -f "$$dir/terraform/terraform.tfstate" ]; then \
				echo "  ✅ Day $$day: Infrastructure deployed"; \
			elif [ -f "$$dir/terraform/.terraform.lock.hcl" ]; then \
				echo "  🔄 Day $$day: Initialized, ready for deployment"; \
			else \
				echo "  ⏳ Day $$day: Not started"; \
			fi; \
		fi; \
	done
	@echo ""
	@echo "📊 For detailed progress: make progress"

progress:
	@echo "Opening progress tracker..."
	@if command -v code >/dev/null 2>&1; then \
		code PROGRESS.md; \
	else \
		echo "📊 Progress tracker: PROGRESS.md"; \
		echo "💡 Install VS Code for better experience: code PROGRESS.md"; \
	fi

# Terraform operations
init:
ifndef DAY
	$(error DAY is required. Usage: make init DAY=01)
endif
	@echo "🔧 Initializing Terraform for Day $(DAY)..."
	@cd day$(DAY)-*/terraform && terraform init

plan:
ifndef DAY
	$(error DAY is required. Usage: make plan DAY=01)
endif
	@echo "📋 Planning Terraform changes for Day $(DAY)..."
	@cd day$(DAY)-*/terraform && terraform plan

apply:
ifndef DAY
	$(error DAY is required. Usage: make apply DAY=01)
endif
	@echo "🚀 Applying Terraform for Day $(DAY)..."
	@cd day$(DAY)-*/terraform && terraform apply

destroy:
ifndef DAY
	$(error DAY is required. Usage: make destroy DAY=01)
endif
	@echo "💥 Destroying resources for Day $(DAY)..."
	@cd day$(DAY)-*/terraform && terraform destroy

# Quick start commands
day1:
	@echo "🎯 Day 1: Foundations & Remote State"
	@echo "Setting up foundational infrastructure..."
	@if [ -d "day01-foundations/terraform" ]; then \
		cd day01-foundations/terraform && terraform init; \
		echo "✅ Day 1 initialized. Next: Review terraform files and run 'make plan DAY=01'"; \
	else \
		echo "❌ Day 1 directory not found"; \
	fi

day11:
	@echo "⚓ Day 11: EKS Cluster Setup"
	@echo "Preparing EKS cluster deployment..."
	@if [ -d "day11-eks/terraform" ]; then \
		cd day11-eks/terraform && terraform init; \
		echo "✅ Day 11 initialized. Next: Run 'make plan DAY=11'"; \
	else \
		echo "❌ Day 11 directory not found"; \
	fi

eks-config:
	@echo "⚓ Configuring kubectl for EKS..."
	@if command -v aws >/dev/null 2>&1 && command -v kubectl >/dev/null 2>&1; then \
		echo "🔧 Run: aws eks update-kubeconfig --region <region> --name <cluster-name>"; \
		echo "💡 Replace <region> and <cluster-name> with your values"; \
	else \
		echo "❌ AWS CLI or kubectl not found. Please install both tools."; \
	fi

# Cleanup operations
clean:
	@echo "🧹 Cleaning Terraform temporary files..."
	@find . -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.tfplan" -type f -delete 2>/dev/null || true
	@find . -name "terraform.tfstate.backup" -type f -delete 2>/dev/null || true
	@echo "✅ Cleanup complete"

# Validation operations
lint:
	@echo "🔍 Running tflint on all Terraform configurations..."
	@if command -v tflint >/dev/null 2>&1; then \
		find . -name "*.tf" -path "*/terraform/*" -exec dirname {} \; | sort -u | while read dir; do \
			echo "Linting $$dir"; \
			cd "$$dir" && tflint; \
			cd - >/dev/null; \
		done; \
	else \
		echo "⚠️  tflint not installed. Install with: brew install tflint"; \
	fi

validate:
	@echo "✅ Validating all Terraform configurations..."
	@find . -name "*.tf" -path "*/terraform/*" -exec dirname {} \; | sort -u | while read dir; do \
		echo "Validating $$dir"; \
		cd "$$dir" && terraform validate; \
		cd - >/dev/null; \
	done

# Documentation
docs:
	@echo "📖 Updating documentation..."
	@echo "Generating day-wise summaries..."
	@for day in $$(seq -w 1 14); do \
		if [ -d "day$$day-*" ]; then \
			dir=$$(ls -d day$$day-* 2>/dev/null | head -1); \
			echo "Day $$day: $$dir" >> docs/day-summary.md; \
		fi; \
	done
	@echo "✅ Documentation updated"

# Development helpers
install-tools:
	@echo "🛠️  Installing development tools..."
	@echo "This will install: terraform, aws-cli, kubectl, helm, tflint"
	@echo "⚠️  Please run manually based on your OS:"
	@echo ""
	@echo "Windows (using Chocolatey):"
	@echo "  choco install terraform awscli kubernetes-cli kubernetes-helm tflint"
	@echo ""
	@echo "macOS (using Homebrew):"
	@echo "  brew install terraform awscli kubectl helm tflint"
	@echo ""
	@echo "Linux (using package managers):"
	@echo "  # Install terraform, aws-cli, kubectl, helm, tflint via your package manager"

# Check prerequisites
check-prereqs:
	@echo "🔍 Checking prerequisites..."
	@command -v terraform >/dev/null 2>&1 && echo "✅ Terraform installed" || echo "❌ Terraform missing"
	@command -v aws >/dev/null 2>&1 && echo "✅ AWS CLI installed" || echo "❌ AWS CLI missing"
	@command -v kubectl >/dev/null 2>&1 && echo "✅ kubectl installed" || echo "❌ kubectl missing"
	@command -v helm >/dev/null 2>&1 && echo "✅ Helm installed" || echo "❌ Helm missing"
	@command -v git >/dev/null 2>&1 && echo "✅ Git installed" || echo "❌ Git missing"
	@echo ""
	@echo "💡 To install missing tools: make install-tools"
