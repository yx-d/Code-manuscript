from pina import PinchAnalyzer, make_stream

# make_stream(heat flow, supply temperature, target temperature, individual temp_shift) The detailed data is from the referred industrial processes
# edible oil
c1 = make_stream(-812, 20, 90)
c2 = make_stream(-174.3, 20, 70)
c3 = make_stream(428.4, 20, 70)
h1 = make_stream(986, 90, 5)

min_temp_diff = 10
temp_shift = min_temp_diff / 2

analyzer = PinchAnalyzer(temp_shift)
analyzer.add_streams(c1,h1)


from matplotlib import pyplot as plt

fig, ax = plt.subplots(1, 2, figsize=(16, 7))
a=analyzer.hot_composite_curve#导出绘图数据
b=analyzer.cold_composite_curve
c=analyzer.grand_composite_curve

ax[0].plot(*analyzer.hot_composite_curve, color="tab:red", linestyle="--", label="HCC")
ax[0].plot(*analyzer.cold_composite_curve, color="tab:blue", linestyle="-", label="CCC")
ax[0].legend()
ax[0].set_title("Hot and cold composite curves")
ax[0].set_xlabel("Heat flow [kW]")
ax[0].set_ylabel("Actual temperature [\u2103]")

ax[1].plot(*analyzer.grand_composite_curve, color="k", linestyle="-", label="GCC")
ax[1].legend()
ax[1].set_title("Grand composite curve")
ax[1].set_xlabel("Net heat flow [kW]")
ax[1].set_ylabel("Shifted temperature [\u2103]")

# Make the y-axis equal in both plots
ylims = (*ax[0].get_ylim(), *ax[1].get_ylim())
minmax_ylims = (min(ylims), max(ylims))
ax[0].set_ylim(minmax_ylims)
ax[1].set_ylim(minmax_ylims)

plt.show()