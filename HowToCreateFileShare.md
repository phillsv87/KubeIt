# How to create the default static file share
1. Run ./CreateFileShare.ps1 -name example
2. Copy Storage account name and key into config using the storageAccountName and storageAccountKey properties
3. Run ./CreateSecretForFileShare.ps1
4. Run ./MakeFileShareVolume.ps1 -name example -storageAccountName examplestorage -shareName exampleshare -sizeGB 100
5. kubectl apply -f ../example-pv.yml
6. Add volume mount to pod or deployment
```yml
      volumes:
      - name: example-volume
        persistentVolumeClaim:
          claimName: pvc-gdatashare
```