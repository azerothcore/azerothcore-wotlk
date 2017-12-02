function hwc_git_subtree_list() {
	git log | grep git-subtree-dir | tr -d ' ' | cut -d ":" -f2 | sort | uniq
}
