

```mermaid
graph LR
    DNS(DNS<br/>solo.lab -> VIP)
    LB(LoadBalancer<BR/>VIP->Host_IP)
    Traefik_Svc(Traefik_Svc<br/>ingressSvc<br/>type: loadBalancer)
    Traefik_Pod(Traefik_Pod<br/>ingressPod<br/>Ingress Controller)
    App1_Ing(App1_Ing)
    App1_Svc(App1_Svc)
    App2_Ing(App2_Ing)
    App2_Svc(App2_Svc)
    
    DNS--step1-->LB--step2-->Traefik_Svc--step3-->Traefik_Pod
    Traefik_Pod--step4: refer-->Traefik_dashboard_Ing-->Traefik_dashboard_Svc
    Traefik_Pod--step5-->Traefik_dashboard_Svc
    Traefik_dashboard_Svc--step6-->Traefik_Pod
    Traefik_Pod--refer-->App1_Ing
    App1_Ing-->App1_Svc
    Traefik_Pod-->App1_Svc
    App1_Svc-->App1_App
    Traefik_Pod--refer-->App2_Ing
    App2_Ing-->App2_Svc
    Traefik_Pod-->App2_Svc
    App2_Svc-->App2_App
```

```mermaid
classDiagram
    DNS --> LoadBalancer : step 1

    DNS : solo.lab -> VIP
    LoadBalancer : VIP->Host_IP
```

```mermaid
classDiagram
    DNS --> LoadBalancer

    DNS : solo.lab -> VIP
    LoadBalancer : VIP->Host_IP
```

```mermaid
classDiagram
    %%DNS --> LoadBalancer
    %%LoadBalancer --> "Host" Traefik_Svc
    Traefik_Svc --> Traefik_Pod
    Traefik_Pod <--> Traefik_dashboard_Ing
    Traefik_Pod <--> App1_Ing
    Traefik_Pod <--> App2_Ing
    Traefik_Pod --> Traefik_dashboard_Svc
    Traefik_dashboard_Svc --> Traefik_Pod
    Traefik_dashboard_Ing --> Traefik_dashboard_Svc
    Traefik_Pod --> App1_Svc
    App1_Ing --> App1_Svc
    Traefik_Pod --> App2_Svc
    App1_Svc --> App1_Pod
    App2_Ing --> App2_Svc
    App2_Svc --> App2_Pod

    %%DNS : solo.lab -> VIP
    %%LoadBalancer : VIP->Host_IP
    Traefik_Svc : ingressSvc 
    Traefik_Svc:type(loadBalancer)
    Traefik_Pod : ingressPod
    Traefik_Pod:(ingress_controller)
    Traefik_dashboard_Ing : traefik-dashboard
    Traefik_dashboard_Ing : host(solo.lab)
    Traefik_dashboard_Ing : backend_name(traefik-dashboard)
    Traefik_dashboard_Ing : backend_port(9000)
    Traefik_dashboard_Svc : traefik-dashboard
    Traefik_dashboard_Svc : port(9000)
    Traefik_dashboard_Svc : targetPort(traefik)
    Traefik_dashboard_Svc : protocol(tcp)
```

```mermaid
classDiagram
    %%DNS --> LoadBalancer : step 1
    %%LoadBalancer --> "Host" Traefik_Svc : step 2
    Traefik_Svc --> Traefik_Pod : step 3
    Traefik_Pod <--> Traefik_dashboard_Ing : refer(step4)
    Traefik_Pod <--> App1_Ing : refer
    Traefik_Pod <--> App2_Ing : refer
    Traefik_Pod --> Traefik_dashboard_Svc : step5
    Traefik_dashboard_Svc --> Traefik_Pod : step6
    Traefik_dashboard_Ing --> Traefik_dashboard_Svc
    Traefik_Pod --> App1_Svc
    App1_Ing --> App1_Svc
    Traefik_Pod --> App2_Svc
    App1_Svc --> App1_Pod
    App2_Ing --> App2_Svc
    App2_Svc --> App2_Pod

    %%DNS : solo.lab -> VIP
    %%LoadBalancer : VIP->Host_IP
    Traefik_Svc : ingressSvc 
    Traefik_Svc:type(loadBalancer)
    Traefik_Pod : ingressPod
    Traefik_Pod:(ingress_controller)
    Traefik_dashboard_Ing : traefik-dashboard
    Traefik_dashboard_Ing : host(solo.lab)
    Traefik_dashboard_Ing : backend_name(traefik-dashboard)
    Traefik_dashboard_Ing : backend_port(9000)
    Traefik_dashboard_Svc : traefik-dashboard
    Traefik_dashboard_Svc : port(9000)
    Traefik_dashboard_Svc : targetPort(traefik)
    Traefik_dashboard_Svc : protocol(tcp)
```