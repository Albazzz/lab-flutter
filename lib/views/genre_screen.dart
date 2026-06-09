import 'package:flutter/material.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import '../theme/apple_design.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final MovieController _controller = MovieController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800;
            
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppleDesign.spacingLg,
                    vertical: AppleDesign.spacingXl,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find a Movie',
                          style: isWide 
                              ? AppleDesign.heroDisplay 
                              : AppleDesign.displayLg.copyWith(fontSize: 34),
                        ),
                        const SizedBox(height: AppleDesign.spacingLg),
                        _buildSearchBar(),
                        const SizedBox(height: AppleDesign.spacingLg),
                        _buildGenreSection(),
                        const SizedBox(height: AppleDesign.spacingLg),
                        _buildSortBar(),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppleDesign.spacingLg),
                  sliver: _buildMovieLayout(isWide),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: AppleDesign.spacingSection)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppleDesign.canvasParchment,
        borderRadius: BorderRadius.circular(AppleDesign.roundedPill),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppleDesign.spacingMd),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppleDesign.bodyMuted, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: _controller.updateSearch,
              style: AppleDesign.body,
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                hintStyle: TextStyle(color: AppleDesign.bodyMuted),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreSection() {
    final selectedGenres = _controller.selectedGenres;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Genres', style: AppleDesign.bodyStrong),
            if (selectedGenres.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppleDesign.primary,
                  borderRadius: BorderRadius.circular(AppleDesign.roundedPill),
                ),
                child: Text(
                  '${selectedGenres.length}',
                  style: AppleDesign.caption.copyWith(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
            const Spacer(),
            if (selectedGenres.isNotEmpty)
              TextButton(
                onPressed: _controller.clearGenres,
                child: const Text('Clear', style: TextStyle(color: AppleDesign.primary)),
              ),
          ],
        ),
        const SizedBox(height: AppleDesign.spacingSm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _controller.availableGenres.map((genre) {
            final isSelected = selectedGenres.contains(genre);
            return GestureDetector(
              onTap: () => _controller.toggleGenre(genre),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppleDesign.primary : AppleDesign.canvasParchment,
                  borderRadius: BorderRadius.circular(AppleDesign.roundedPill),
                ),
                child: Text(
                  genre,
                  style: AppleDesign.caption.copyWith(
                    color: isSelected ? Colors.white : AppleDesign.ink,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortBar() {
    return Row(
      children: [
        const Text('Sort by:', style: AppleDesign.bodyStrong),
        const SizedBox(width: 12),
        DropdownButton<String>(
          value: _controller.selectedSort,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppleDesign.primary),
          items: _controller.sortOptions.map((opt) {
            return DropdownMenuItem(
              value: opt,
              child: Text(opt, style: AppleDesign.body.copyWith(color: AppleDesign.primary)),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) _controller.updateSort(val);
          },
        ),
      ],
    );
  }

  Widget _buildMovieLayout(bool isWide) {
    final movies = _controller.getFilteredMovies();
    if (movies.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Center(
            child: Text('No movies found', style: AppleDesign.body),
          ),
        ),
      );
    }
    return isWide 
        ? SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieCard(movie: movies[index]),
              childCount: movies.length,
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _MovieCard(movie: movies[index]),
              ),
              childCount: movies.length,
            ),
          );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppleDesign.canvas,
        borderRadius: BorderRadius.circular(AppleDesign.roundedLg),
        border: Border.all(color: AppleDesign.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppleDesign.canvasParchment,
                child: const Icon(Icons.movie, color: AppleDesign.bodyMuted),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppleDesign.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    style: AppleDesign.bodyStrong,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${movie.year} • ${movie.genres.join(", ")}',
                    style: AppleDesign.caption.copyWith(color: AppleDesign.bodyMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toString(),
                        style: AppleDesign.caption.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
