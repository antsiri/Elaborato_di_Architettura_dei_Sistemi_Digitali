# Definizione del clock principale
create_clock -name CLK -period 10.0 [get_ports CLK]
# (Modifica "10.0" con il periodo del tuo clock in nanosecondi, ad esempio 10.0 ns corrisponde a 100 MHz)

# Specifica i vincoli di temporizzazione sui percorsi del design
# Setup timing (permette al progetto di rispettare il setup time dei registri)
set_max_delay -from [get_ports START] -to [get_ports Y] 10.0
set_max_delay -from [get_ports RST] -to [get_ports Y] 10.0

# Hold timing (garantisce che i segnali rimangano stabili durante l'hold time)
set_min_delay -from [get_ports START] -to [get_ports Y] 0.5
set_min_delay -from [get_ports RST] -to [get_ports Y] 0.5

# Vincoli sui percorsi interni tra componenti
set_max_delay -from [get_pins ROM0/dout] -to [get_pins M0/ingresso] 10.0
set_max_delay -from [get_pins M0/uscita] -to [get_pins MEM0/DATA_IN] 10.0

# Se ci sono percorsi che non devono essere analizzati (come percorsi asincroni o non rilevanti):
# False paths
set_false_path -from [get_pins ROM0/dout] -to [get_pins M0/uscita]
