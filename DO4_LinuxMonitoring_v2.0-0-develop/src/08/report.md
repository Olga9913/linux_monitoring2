## Part 8. A ready-made dashboard

> [Copy ID](https://grafana.com/grafana/dashboards/13978-node-exporter-quickstart-and-dashboard/) of the ready-made dashboard Node Exporter Quickstart and Dashboard from Grafana Labs and [load](http://localhost:3000/dashboard/import) it in Grafana

> Then configure static routing between two machines for the network load test

1) `/etc/netplan/00-installer-config.yaml`

**Main machine**

![ws11_netplan](./screenshots/ws11_netplan.png)

**Another machine**

![ws21_netplan](./screenshots/ws21_netplan.png)
    
sudo netplan apply


2) add a static route

**Main machine**

    sudo ip r add 172.24.116.8 dev enp0s8

**Another machine**

    sudo ip r add 192.168.100.10 dev enp0s8

3) measure connection speed between two machines

**Main machine**

    iperf3 -s -f K

**Another machine**

    iperf3 -c 192.168.100.10 -f K


> Dashbord view with the same tests as in Part 7 and the network load test

![imported dashboard](./screenshots/after_iperf3_full_metrics.png)

---