# Architecture decision records

A hard-to-reverse decision gets one file here, written before or with the change.

The first line is `# NNNN — Title`, with an em dash. The header carries `Status:` and `Date: YYYY-MM-DD`. The body has the sections Context, Decision and Consequences. The filename is `NNNN-short-slug.md`: four digits, lowercase words separated by hyphens, contiguous from 0001, never reused. `tooling/check-repo` checks this.

To change a decision, amend the file and date the amendment, or add a new ADR and name it in the old one's Status. A superseded decision stays in its file. It is not rewritten as though the later decision had always stood.
