function y=bspline_at(x,deg)
absx=abs(x);
y=0;
if deg==3
if absx<1
    y=2/3-(1/2)*absx^2*(2-absx);
elseif absx<2
    y=(1/6)*(2-absx)^3;
end
elseif deg==4
    if absx<=1/2
        y=(1/4)*absx^4-(5/8)*absx^2+115/192;
    elseif absx<3/2
        y=-(1/6)*absx^4+(5/6)*absx^3-(5/4)*absx^2+(5/24)*absx+55/96;
    elseif absx<5/2
        y=(1/24)*absx^4-(5/12)*absx^3+(25/16)*absx^2-(125/48)*absx+625/384;
    end
elseif deg==5
    if absx<1
        y=(-1/12)*absx^5+(1/4)*absx^4-(1/2)*absx^2+11/20;
    elseif absx<2
        y=(1/24)*absx^5 -(3/8)*absx^4 +(5/4)*absx^3 -(7/4)*absx^2 +(5/8)*absx +17/40;
    elseif absx<3
        y=(-1/120)*absx^5 +(1/8)*absx^4 -(3/4)*absx^3 +(9/4)*absx^2 -(27/8)*absx +81/40;
    end
elseif deg==6
    if absx<1/2
        y=(-1/36)*absx^6 +(7/48)*absx^4 -(77/192)*absx^2 +5887/11520;
    elseif absx<3/2
        y=(1/48)*absx^6 -(7/48)*absx^5 +(21/64)*absx^4 -(35/288)*absx^3 -(91/256)*absx^2 -(7/768)*absx +7861/15360;
    elseif absx<5/2
        y=(1/720)*(absx-7/2)^6 -(7/720)*(absx -(5/2))^6;  
    elseif absx<7/2
        y=(1/46080)*(2*absx-7)^2;
    end
elseif deg==7
    if absx<1
        y=polyval([1/144, -1/36, 0, 1/9, 0, -1/3, 0, 151/315],absx);
    elseif absx<2
        y=polyval([-1/240, 1/20, -7/30, 1/2, -7/18, -1/10, -7/90, 103/210],absx);
    elseif absx<3
        y=polyval([1/720,-1/36, 7/30, -19/18, 49/18, -23/6, 217/90, -139/630],absx);
       % y=(1/720)*(absx-7/2)^6 -(7/720)*(absx -(5/2))^6;
    elseif absx<4
        y=-(1/5040)*(absx-4)^7;
    end
end
    