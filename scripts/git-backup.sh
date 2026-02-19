#!/bin/bash

# Workspace Backup Script
# Runs at 4am daily, commits all changes and pushes to origin

WORKSPACE="/Users/dipesh/.openclaw/workspace"
LOG_DIR="$WORKSPACE/logs"
LOG_FILE="$LOG_DIR/git-backup.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Start logging
{
    echo "=========================================="
    echo "🔄 Backup Job: $TIMESTAMP"
    echo "=========================================="
    
    cd "$WORKSPACE" || exit 1
    
    # Check for changes
    if git status --porcelain | grep -q .; then
        echo "📝 Changes detected, committing..."
        git add -A
        git commit -m "Backup: $TIMESTAMP - Auto-commit from 4am backup routine"
        echo "✅ Commit successful"
    else
        echo "✓ No changes to commit"
    fi
    
    # Push to remote
    echo "📤 Pushing to origin..."
    if git push origin main 2>&1; then
        echo "✅ Push successful"
        echo "Status: SUCCESS"
    else
        echo "❌ Push failed"
        echo "Status: FAILED"
        exit 1
    fi
    
    echo "=========================================="
    echo ""
} >> "$LOG_FILE" 2>&1

exit 0
