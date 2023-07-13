# Usage
## Build a docker image
docker build -t fingerprinter .

# Update the image
docker run --name fingerprinter-update -it fingerprinter --update-all
docker commit fingerprinter-update fingerprinter:latest
docker rm fingerprinter-update

# Run the image
docker run --rm -it fingerprinter <fingerprinter options>

