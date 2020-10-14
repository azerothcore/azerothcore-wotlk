# Workflow to associate labels automatically
name: labeler
# Trigger the workflow on pull request events
on: [pull_request]
jobs:
  label:
    runs-on: ubuntu-18.04
    steps:
      # We need to checkout the repository to access the configured file (.github/label-pr.yml)
      - uses: actions/checkout@v2
      - name: Labeler
        uses: docker://decathlon/pull-request-labeler-action:2.0.0
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          # Here we can override the path for the action configuration. If none is provided, default one is `.github/label-pr.yml`
          CONFIG_PATH: ${{ secrets.GITHUB_WORKSPACE }}/.github/label-pr.yml
