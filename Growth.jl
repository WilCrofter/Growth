
using Plots, Dates

"""
     percentage_growth(d::Real, p::Real, Y::Real)

Suppose you invest d dollars per month in an asset, such as a stock, which pays p percent per year. Return the investment's value for today through Y years from today.

# Examples
```julia-repl
julia> # Growth of investing d dollars per month for Y years in an asset paying 5% interest.
julia> dates, values = G.percentage_growth(100,5,30);
julia> scatter(dates, values, xlabel="Date", ylabel="Value in dollars",legend=false,formatter=:plain)
```
"""
function percentage_growth(d::Real, p::Real, Y::Integer)
    # Check that parameters make sense
    @assert d≥0
    @assert 0≤p≤100
    @assert Y≥0
    # Convert the annual percentage to a monthly rate of growth
    monthly = 1+p/1200
    # Make a list of dates from now until Y years from now, by month
    dates = [today()+Month(i) for i in 0:(12*Y)]
    # Compute the corresponding values
    values = fill(0.0, length(dates)) # a place to keep the numbers
    values[1] = d # first month's investment
    for i in 2:length(values)
        # investment (d) + interest in month i
        values[i] = d + values[i-1]*monthly
    end
    return dates, values
end

"""
    total_cost(d::Real, p::Real, Y::Real)

Calculate the monthly payment and total cost of borrowing d dollars for Y years at an interest rate of p percent per year.

# Examples
```julia-repl
# Monthly payment and total cost of a 1000 dollar loan
# at 5% interest for 4 years.
julia> payment, cost = total_cost(1000.0,5,4)
```
"""
function total_cost(d::Real, p::Real, Y::Real)
    # Check that parameters make sense
    @assert d≥0
    @assert 0≤p≤100
    @assert Y≥0
    # Convert the annual percentage to a monthly rate
    monthly = 1+p/1200
    # Round years, Y, to the nearest month.
    # There will be M equal monthly payments.
    M = round(Int,Y*12)
    # Calculate the monthly payment.
    # (Some math is required to arrive at this formula.)
    payment = (monthly-1)*d*monthly^M/(monthly^M-1)
    # Calculate the total cost of M monthly payments.
    full_cost = M*payment
    # Return the monthly payment and total cost
    return payment, full_cost
end

nothing
