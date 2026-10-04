# def.ms

Source of https://def.ms: the DEFMS landing page and the protocol specification.

## Layout

- `site/`: static files copied verbatim to the web root
- `spec/vX.Y.md`: one file per spec draft, GitHub-flavored markdown
- `spec/template.html`: pandoc template shared by every draft
- `build.sh`: renders `site/` and every draft into `build/`
- `Dockerfile`: pandoc build stage, then `quay.io/epheo/kiss` serving `build/`

Every draft is served at `/spec/vX.Y/`. The highest version is also served at `/spec/`.

## Preview

```
make html    # render into build/
make serve   # serve build/ on http://localhost:8080 with kiss
make image   # build the container locally
```

## Publish

Push to `main`. GitHub Actions builds the image and pushes `ghcr.io/epheo/def-ms:latest`.
ArgoCD in the defms cluster runs that image and serves it at def.ms.

## License

Apache License 2.0, for the specification text and everything else in this repository. See `LICENSE`.
