-- Very simple VPN status info

function vpnInfo(tunnel)
    status = " VPN: N/A "

    fp = io.popen("ip route | grep "..tunnel, "r")
    if fp then
       if fp:read() == nil then
	  status = " <span color='#FF0000'>VPN: OFF</span> "
       else
	  status = " <span color='#00FF00'>VPN: ON</span> "
       end
       fp:close()
    end

    return status
end
