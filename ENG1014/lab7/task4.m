% Campbell Gregor
% Last modified: 6/9/22
% 33110018

clc; clear all; close all;

% Import Data 
bookData = importdata("books.xlsx");

bookMasses = bookData.data(:,1)./1000;

bookHeights =  bookData.data(:,2);

bookCats = bookData.textdata(2:end,3)';


bookEnergies = BookEnergy(bookMasses,bookHeights);

% Convert to array since I can't use cell types properly
temp = [];
 for i = 1:length(bookCats)
    test = string(bookCats{i});
    temp = [temp,test];
 end

bookCats = temp';


% Find Index of star wars books and get values for them
starwarsIndex = bookCats == "star_wars";
StarWarsMass = bookMasses(starwarsIndex);
StarWarsHeight = bookHeights(starwarsIndex);
StarWarsEnergies = bookEnergies(starwarsIndex,:);
StarWarsMass = StarWarsMass';

% Print to screen
fprintf("STAR WARS BOOKS\n")

fprintf("\t Mass (kg) \t Height (m) \t Potential Energy (J) \t KE Halfway (J) \t Vel_floor (m/s)\n")

for i = 1:length(StarWarsHeight)
    fprintf(" %15.1f  %14.1f  %19.4f  %19.4f  %23.5f\n", StarWarsMass(i), StarWarsHeight(i), ...
        StarWarsEnergies(i,1), StarWarsEnergies(i,2), StarWarsEnergies(i,3))
end






