echo "Init unfold called with params: $@"
operation=$1
mkdir -p $INSTALL_HOME
folder="$INSTALL_HOME"
if [ "$file" = ".config" ]; then
    folder=$HOME
fi
cd $folder
tar -xzf $BACKUP_HOME/$operation.tar.gz &
echo "Finished unfold $operation"
