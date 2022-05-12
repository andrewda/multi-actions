INSTALL_DIR="/home/ubuntu/github"

while [[ $# -gt 0 ]]; do
  case $1 in
    --token)
      TOKEN="$2"
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

for d in $INSTALL_DIR/runner-*/
do
  cd "$d"

  sudo ./svc.sh uninstall
  ./config.sh remove --unattended --token "$TOKEN"
done
