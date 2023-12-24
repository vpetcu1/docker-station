echo "Init fold called with params: $@"
operation=$1
mkdir -p $BACKUP_HOME
folder="$INSTALL_HOME"
if [ "$file" = ".config" ]; then
    folder=$HOME
fi
cd $folder
tar -czf $BACKUP_HOME/$operation.tar.gz $operation/
echo "Finished fold $operation"
cd $INIT_HOME
sh upload.sh $operation.tar.gz &
