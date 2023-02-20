
import Config

config :bonny,

  # Function to call to get a K8s.Conn object.
  # The function should return a %K8s.Conn{} struct or a {:ok, %K8s.Conn{}} tuple
  # get_conn: {GameserverOperator.K8sConn, :get!, [config_env()]},
  get_conn: {K8s.Conn, :from_file, ["~/.kube/config"]}

  # Name must only consist of only lowercase letters and hyphens.
  # Defaults to hyphenated mix app name
  service_account_name: "gameserver-operator",

  # Labels to apply to the operator's resources.
  labels: %{
    "k8s-app" => "gameserver-operator"
  },

  # Operator deployment resources. These are the defaults.
  resources: %{limits: %{cpu: "200m", memory: "200Mi"}, requests: %{cpu: "200m", memory: "200Mi"}},

  manifest_override_callback: &Mix.Tasks.Bonny.Gen.Manifest.GameserverOperatorCustomizer.override/1
