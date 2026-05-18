apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mssql-kubeinvaders
  labels:
    app: mssql

spec:
  serviceName: mssql-headless
  replicas: 20
  podManagementPolicy: Parallel

  selector:
    matchLabels:
      name: mssql-pod

  template:
    metadata:
      labels:
        name: mssql-pod

    spec:
      tolerations:
        - key: node.kubernetes.io/unreachable
          operator: Exists
          effect: NoExecute
          tolerationSeconds: 10
        - key: node.kubernetes.io/not-ready
          operator: Exists
          effect: NoExecute
          tolerationSeconds: 10

      securityContext:
        fsGroup: 10001

      containers:
        - name: mssql-container
          image: mcr.microsoft.com/mssql/server:2025-CU3-ubuntu-24.04

          ports:
            - containerPort: 1433
              name: mssql-port

          env:
            - name: MSSQL_PID
              value: "Developer"
            - name: ACCEPT_EULA
              value: "Y"
            - name: MSSQL_AGENT_ENABLED
              value: "1"
            - name: MSSQL_DATA_DIR
              value: /opt/mssql/data
            - name: MSSQL_LOG_DIR
              value: /opt/mssql/log
            - name: MSSQL_SA_PASSWORD
              value: "Testing1122"