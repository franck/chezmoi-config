# Pulumi wrapper to invalidate prompt cache after stack operations
function pulumi
  command pulumi $argv

  # Invalidate cache after stack-changing operations
  if set -q argv[1]; and contains -- $argv[1] stack select init
    set -e _pulumi_cache_key
    set -e _pulumi_cache_stack
  end
end
