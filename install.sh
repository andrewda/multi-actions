INSTALL_DIR="/home/ubuntu/github"

COUNT=$(grep -c ^processor /proc/cpuinfo)

VERSION="2.291.1"
CHECKSUM="1bde3f2baf514adda5f8cf2ce531edd2f6be52ed84b9b6733bf43006d36dcd4c"

while [[ $# -gt 0 ]]; do
  case $1 in
    --url)
      URL="$2"
      shift # past argument
      shift # past value
      ;;
    --token)
      TOKEN="$2"
      shift # past argument
      shift # past value
      ;;
    --count)
      COUNT="$2"
      shift # past argument
      shift # past value
      ;;
    --version)
      VERSION="$2"
      shift # past argument
      shift # past value
      ;;
    --checksum)
      CHECKSUM="$2"
      shift # past argument
      shift # past value
      ;;
    --dir)
      INSTALL_DIR="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

mkdir -p "$INSTALL_DIR" && cd "$INSTALL_DIR"
curl -o "actions-runner-linux-x64-$VERSION.tar.gz" -L "https://github.com/actions/runner/releases/download/v$VERSION/actions-runner-linux-x64-$VERSION.tar.gz"
echo "$CHECKSUM  actions-runner-linux-x64-$VERSION.tar.gz" | shasum -a 256 -c

for i in $(seq 1 $COUNT)
do
  cd "$INSTALL_DIR" && mkdir "runner-$i" && cd "runner-$i"
  tar xzf "$INSTALL_DIR/actions-runner-linux-x64-$VERSION.tar.gz"

  ./config.sh \
    --unattended \
    --url "$URL" \
    --token "$TOKEN" \
    --name "$(hostname).$i" \
    --labels "$(hostname)" \
    --replace

  # Install and start Runner Service
  sudo ./svc.sh install
  sudo ./svc.sh start
done
