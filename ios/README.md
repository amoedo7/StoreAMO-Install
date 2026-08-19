# StoreAMO en iPhone / iPad

StoreAMO no intenta instalar APK en iOS. La entrada para iPhone y iPad es **StoreAMO Web/PWA**.

Cuando la web pública quede desplegada, el flujo será:

1. abrir StoreAMO Web en Safari;
2. StoreAMO detecta iOS localmente;
3. muestra primero apps Web/iOS compatibles;
4. `Ver más dispositivos` permite consultar Android, Windows, macOS o Linux;
5. opcionalmente usar **Compartir → Añadir a pantalla de inicio** para una experiencia tipo app.

Las aplicaciones iOS nativas, si se publican en el futuro, deberán declarar su artefacto oficial en su propio `storeamo.json`; StoreAMO nunca ofrecerá un APK como si fuera instalable en iPhone.
