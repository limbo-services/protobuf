set -e

cp merge-pending-pr.sh /tmp/merge-pending-pr.sh
git checkout downstream
git reset --hard fd/master

git merge --no-edit --no-ff --no-commit fd/patch-1 fd/casttype-messages fd/init-functions fd/server-options fd/better-camel-case
git commit -m "Merged pending pull requests"

cp /tmp/merge-pending-pr.sh merge-pending-pr.sh
git add merge-pending-pr.sh
find . -type f -name "*.go" -exec sed -i '' 's|github.com/gogo/protobuf|limbo.services/protobuf|g' {} +
find . -type f -name "*.proto" -exec sed -i '' 's|github.com/gogo/protobuf|limbo.services/protobuf|g' {} +
git add -u
git commit --amend --no-edit
git push origin downstream:master --force
